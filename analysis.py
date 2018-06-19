#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jun 14 11:40:44 2018

@author: florian
"""

import seaborn as sbs
import pandas as pd
import matplotlib.pyplot as plt
import os
import math
import numpy as np

#%%

DATASETS_PREFIX = 'Data/'
sbs.set_context("talk", font_scale=1.5)

dataset_paths = os.listdir(DATASETS_PREFIX)

datasets = [pd.read_csv(os.path.join(DATASETS_PREFIX, path), '\t') for path in dataset_paths]

f, ax = plt.subplots(1, 1)
x_col='Time [log(ms)]'
y_col = 'frequency'

hist_kws = {'bins': 20}

for i, df in enumerate(datasets):
    df = df.infer_objects()
    df = df[df['t1st(ms)'] != 0]
    df['log(t1st(ms))'] = df['t1st(ms)'].apply(math.log)
    df = df[df['log(t1st(ms))'] > 5]
    sbs.distplot(df['log(t1st(ms))'], label=dataset_paths[i], ax=ax, bins=10)
    
#ax.legend()
#%%

for i, df in enumerate(datasets):
    std = np.std(df['t1st(ms)'])
    print("{} has a stddev of {:5}".format(dataset_paths[i], std))

#%%


#%%
plot = sbs.lmplot(data=frame, x="index1", y="t1st(ms)", hue="condiID",fit_reg=False, aspect=2, size=10)

#%%

plot.savefig("scatterplot.png")