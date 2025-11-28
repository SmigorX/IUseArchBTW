return {
  {
    "narutoxy/silicon.lua",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local silicon = require("silicon")
      
      silicon.setup({
        theme = "auto",
        output = "~/Pictures/SILICON_$year-$month-$date-$time.png",
        -- ... reszta configu jak w przykładzie
        debug = false,

        watermark = {
            text = "SmigorX",
        },

        bgColor = vim.g.terminal_color_5,
        -- path to image, must be png
        bgImage = "",
        roundCorner = true,
        windowControls = true,
        lineNumber = true,
        font = "monospace",
        -- from where to start line number
        lineOffset = 1,
        -- padding between lines
        linePad = 2,
        -- Horizontal padding
        padHoriz = 40,
        -- vertical padding
        padVert = 40,
        shadowBlurRadius = 10,
        shadowColor = "#555555",
        shadowOffsetX = 8,
        shadowOffsetY = 8,
        -- enable lsautogobble like feature
        gobble = false,
      })

    -- Generate image of lines in a visual selection
    vim.keymap.set('v', '.l',  function() silicon.visualise_api({to_clip = true}) end )
    -- Generate image of a whole buffer, with lines in a visual selection highlighted
    vim.keymap.set('v', '.h', function() silicon.visualise_api({to_clip = true, show_buf = true}) end )
    -- Generate visible portion of a buffer
    vim.keymap.set('n', '.b',  function() silicon.visualise_api({to_clip = true, visible = true}) end )
    -- Generate current buffer line in normal mode
    vim.keymap.set('n', '.f',  function() silicon.visualise_api({to_clip = true}) end )

    end
  }
}
