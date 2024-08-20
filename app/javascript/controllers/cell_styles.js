export const CellStyles = {
  applyStyles(cell, color, opacity = 1) {
    cell.style.backgroundColor = color
    cell.style.opacity = opacity
  },

  darkenColorValue(hex) {
    const darkenValue = 65

    const rgb = [
      parseInt(hex.slice(1, 3), 16),
      parseInt(hex.slice(3, 5), 16),
      parseInt(hex.slice(5, 7), 16)
    ]

    const darkenedRgb = rgb.map(value => Math.max(0, value - darkenValue))

    return `rgb(${darkenedRgb.join(", ")})`
  }
}
