#!/usr/bin/python3
import hashlib
import os
import pathlib
import re
from subprocess import CalledProcessError, call, check_output
import urllib
import urllib.request

from PIL import Image, ImageDraw


DEFAULT_ART_PATH = pathlib.Path(__file__).parent.resolve() / "starred.png"
PLAY_BUTTON_PATH = (
    pathlib.Path(__file__).parent.resolve()
    / "media-playback-start-symbolic.symbolic.png"
)
PAUSE_BUTTON_PATH = (
    pathlib.Path(__file__).parent.resolve()
    / "media-playback-pause-symbolic.symbolic.png"
)
STOPPED_BUTTON_PATH = (
    pathlib.Path(__file__).parent.resolve()
    / "media-playback-stop-symbolic.symbolic.png"
)
MEDIA_IMAGE_PATH = "/tmp/media.png"
MEDIA_CACHE_FOLDER = "/tmp/media_cache"
MAX_TEXT_LENGTH = 35


def find(key, meta, section="xesam", ignore_len=False):
    for line in meta.split("\n"):
        match = re.search(rf"{section}:{key}\ +(.*)$", line)
        if not match:
            continue
        value = match.group(1).strip()
        if not value:
            return "\\-"
        if not ignore_len and len(value) > MAX_TEXT_LENGTH:
            value = value[: MAX_TEXT_LENGTH - 6] + " [...]"
        return value
    return "\\-"


def open_cached_image(path):
    if path == DEFAULT_ART_PATH or not path.startswith("http"):
        return path
    if not os.path.exists(MEDIA_CACHE_FOLDER):
        os.mkdir(MEDIA_CACHE_FOLDER)
    file_hash = hashlib.sha256(path.encode("utf-8")).hexdigest()
    file_path = pathlib.Path(MEDIA_CACHE_FOLDER) / file_hash
    if not file_path.exists():
        try:
            urllib.request.urlretrieve(path, file_path)
        except Exception:
            return DEFAULT_ART_PATH
        img = Image.open(file_path)
        img = img.resize((256, 256), Image.NEAREST)
        print(img.size)
        img.save(file_path, format="png")
    return file_path


def create_media_image(art, volume, muted, playing, pos):
    # draw artwork
    img = Image.new(mode="RGBA", size=(60 + 256, 256))
    art_img = Image.open(open_cached_image(art))
    art_img = art_img.resize((256, 256), Image.NEAREST)
    img.paste(art_img, ((60, 0, 60 + 256, 256)))

    # draw play/pause
    play_image = PLAY_BUTTON_PATH
    if playing == "Stopped":
        play_image = STOPPED_BUTTON_PATH
    if playing == "Paused":
        play_image = PAUSE_BUTTON_PATH
    play_pause = Image.open(play_image)
    play_pause = play_pause.resize((48, 48), Image.NEAREST)
    img.paste(play_pause, ((256, 256 - 48 - 10, 256 + 48, 256 - 10)), play_pause)

    # draw volume_bar / progress_bar
    volume_bar_color = 0xCC00FF00 if muted == "no" else 0xCC0000FF
    volume_bar_height = 255
    draw = ImageDraw.Draw(img)
    draw.rectangle((0, 0, 30, volume_bar_height), fill=0x33FFFFFF)
    draw.rectangle(
        (0, volume_bar_height * (1 - volume), 30, volume_bar_height),
        fill=volume_bar_color,
    )
    draw.rectangle((60, 256 - 5, 60 + 256, 256), fill=0x33FFFFFF)
    draw.rectangle((60, 256 - 5, 60 + 256 * pos, 256), fill=0x6600FF00)

    return img


def load_player_data():
    meta = check_output(["playerctl", "metadata"]).decode()
    title = find("title", meta)
    artist = find("artist", meta)
    album = find("album", meta)
    art = find("artUrl", meta, "mpris", ignore_len=True)
    length = find("length", meta, "mpris", ignore_len=True)
    playing = check_output(["playerctl", "status"]).decode().strip()
    try:
        position = check_output(["playerctl", "position"]).decode().strip()
        pos = 10**6 * float(position) / float(length)
    except (CalledProcessError, ValueError):
        pos = 0
    return title, artist, album, art, playing, pos


def audio_status():
    volume = check_output(["pactl", "get-sink-volume", "@DEFAULT_SINK@"]).decode()
    volume = int(volume.split()[4][:-1])

    muted = check_output(["pactl", "get-sink-mute", "@DEFAULT_SINK@"]).decode()
    muted = muted.split()[-1]
    return volume / 100, muted


volume, muted = audio_status()
try:
    title, artist, album, art, playing, pos = load_player_data()
    if art.startswith("file://"):
        art = art[len("file://") :]
    if not art.startswith("http") and not os.path.exists(art):
        art = DEFAULT_ART_PATH
    body = f"{album}\n{artist}"
except CalledProcessError:
    playing = "Stopped"
    art = DEFAULT_ART_PATH
    title = "Not playing"
    body = ""
    pos = 0.0

img = create_media_image(art, volume, muted, playing, pos)
img.save(MEDIA_IMAGE_PATH)
cmd = ["dunstify", title, body, "-i", MEDIA_IMAGE_PATH, "-r", "28731"]
call(cmd)
