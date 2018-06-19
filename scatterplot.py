# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import seaborn as sbs
import pandas as pd
import matplotlib as plt

#%%

frame = pd.read_csv('pilot.txt', '\t')

frame = frame.infer_objects()

frame['index1'] = frame.index

#%%

sbs.set_context("talk", font_scale=1.5)

plot = sbs.lmplot(data=frame, x="index1", y="t1st(ms)", hue="condiID",fit_reg=False, aspect=2, size=10)

#%%

plot.savefig("scatterplot.png")
