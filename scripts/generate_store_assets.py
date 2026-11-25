"""Generate Play Console store-listing image assets for SimpleCalc.

Produces, from the existing app icon artwork:
  - store_assets/icon_512.png      512x512, Play's "App icon" upload slot.
  - store_assets/feature_graphic.png  1024x500, Play's "Feature graphic" slot.

Run after scripts/generate_icon.py (reuses assets/icon/icon.png).
"""

from PIL import Image, ImageDraw, ImageFont

BACKGROUND = (0x1A, 0x73, 0xE8, 255)
WHITE = (255, 255, 255, 255)
FONT_PATH = "/System/Library/Fonts/Helvetica.ttc"


def generate_icon_512() -> None:
    icon = Image.open("assets/icon/icon.png").convert("RGBA")
    icon.resize((512, 512), Image.LANCZOS).save("store_assets/icon_512.png")


def generate_feature_graphic() -> None:
    width, height = 1024, 500
    image = Image.new("RGBA", (width, height), BACKGROUND)
    draw = ImageDraw.Draw(image)

    glyph_size = 360
    glyph = Image.open("assets/icon/icon.png").convert("RGBA").resize(
        (glyph_size, glyph_size), Image.LANCZOS
    )
    glyph_x = 70
    glyph_y = (height - glyph_size) // 2
    image.paste(glyph, (glyph_x, glyph_y), glyph)

    title_font = ImageFont.truetype(FONT_PATH, 96)
    subtitle_font = ImageFont.truetype(FONT_PATH, 34)

    text_x = glyph_x + glyph_size + 60
    draw.text((text_x, 165), "SimpleCalc", font=title_font, fill=WHITE)
    draw.text(
        (text_x, 280),
        "Simple, fast, no ads",
        font=subtitle_font,
        fill=WHITE,
    )

    image.convert("RGB").save("store_assets/feature_graphic.png")


if __name__ == "__main__":
    generate_icon_512()
    generate_feature_graphic()
    print("Generated store_assets/icon_512.png and store_assets/feature_graphic.png")
