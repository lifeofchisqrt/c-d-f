define(['base/js/namespace', 'base/js/events'], function (Jupyter, events) {
    // Template cells including markdown and imports
  var setUp = function () {
    Jupyter.notebook.insert_cell_at_index('markdown', 0)
      .set_text(`# Introduction
State notebook purpose here`)
    Jupyter.notebook.insert_cell_at_index('markdown', 1).set_text(`### Imports
Import libraries and write settings here.`)
    // Define imports and settings
    Jupyter.notebook.insert_cell_at_index('code', 2)
      .set_text(`# Data manipulation
import pandas as pd
import numpy as np
# Options for pandas
pd.options.display.max_columns = 50
pd.options.display.max_rows = 30
    
# autoreload extension
if 'autoreload' not in ipython.extension_manager.loaded:
    %load_ext autoreload
%autoreload 2
# Visualizations
from matplotlib import pyplot as plt
import seaborn as sns
sns.set_style('white')
  
np.random.seed(42)  
  `)
      Jupyter.notebook.insert_cell_at_index('markdown', 3)
        .set_text(`# Analysis/Modeling
  Do work here`)
      Jupyter.notebook.insert_cell_at_index('markdown', 4).set_text(`# Results
  Show graphs and stats here`)
      Jupyter.notebook.insert_cell_at_index('markdown', 5)
        .set_text(`# Conclusions and Next Steps
  Summarize findings here`)
      // Run all cells
      Jupyter.notebook.execute_all_cells()
    }
    // Prompts user to enter name for notebook
    var promptName = function () {
      // Open rename notebook box if 'Untitled' in name
      if (Jupyter.notebook.notebook_name.search('Untitled') != -1) {
        document.getElementsByClassName('filename')[0].click()
      }
    }
    // Run on start
    function load_ipython_extension () {
      // Add default cells for new notebook
      if (Jupyter.notebook.get_cells().length === 1) {
        setTimeout(setUp, 500)
      } else {
        promptName()
      }
    }
    // Run when notebook is saved
    events.on('before_save.Notebook', function () {
      promptName()
    })
    return {
      load_ipython_extension: load_ipython_extension
    }
  })