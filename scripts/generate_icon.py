"""Generate SimpleCalc's launcher icon assets with Pillow.

Draws a minimalist calculator glyph (a "screen" bar over a 3x3 button
grid) with no external image assets, producing:
  - assets/icon/icon.png            1024x1024, solid background (legacy icon)
  - assets/icon/icon_foreground.png 1024x1024, transparent (adaptive icon
    foreground), glyph scaled to the central 66% safe zone.
"""

from PIL import Image, ImageDraw

SIZE = 1024
BACKGROUND = (0x1A, 0x73, 0xE8, 255)
WHITE = (255, 255, 255, 255)
TRANSPARENT = (0, 0, 0, 0)


def draw_glyph(draw: ImageDraw.ImageDraw, left: int, top: int, right: int, bottom: int) -> None:
    """Draw the screen+3x3-grid glyph inside the given bounding box."""
    width = right - left
    height = bottom - top

    screen_height = height * 0.25
    screen_rect = (left, top, right, top + screen_height)
    draw.rounded_rectangle(screen_rect, radius=width * 0.05, fill=WHITE)

    grid_top = top + screen_height + height * 0.08
    grid_height = bottom - grid_top
    gap = width * 0.06
    cell_size = (width - 2 * gap) / 3

    for row in range(3):
        for col in range(3):
            cell_left = left + col * (cell_size + gap)
            cell_top = grid_top + row * (cell_size + gap)
            cell_rect = (
                cell_left,
                cell_top,
                cell_left + cell_size,
                cell_top + cell_size,
            )
            draw.rounded_rectangle(cell_rect, radius=cell_size * 0.2, fill=WHITE)


def generate_icon() -> None:
    image = Image.new("RGBA", (SIZE, SIZE), BACKGROUND)
    draw = ImageDraw.Draw(image)
    margin = SIZE * 0.17
    draw_glyph(draw, margin, margin, SIZE - margin, SIZE - margin)
    image.save("assets/icon/icon.png")


def generate_foreground() -> None:
    image = Image.new("RGBA", (SIZE, SIZE), TRANSPARENT)
    draw = ImageDraw.Draw(image)
    # Safe zone is the central 66% of the canvas.
    safe_margin = SIZE * (1 - 0.66) / 2
    draw_glyph(draw, safe_margin, safe_margin, SIZE - safe_margin, SIZE - safe_margin)
    image.save("assets/icon/icon_foreground.png")


if __name__ == "__main__":
    generate_icon()
    generate_foreground()
    print("Generated assets/icon/icon.png and assets/icon/icon_foreground.png")
