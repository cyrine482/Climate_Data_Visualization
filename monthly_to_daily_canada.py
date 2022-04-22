# -*- coding: utf-8 -*-
"""
Created on Thu Apr 21 12:29:10 2022

@author: tenin
"""

import pandas as pd 
import numpy as np
import dateutil
import datetime as dt
from lmfit.models import PolynomialModel
import matplotlib.pyplot as plt
df = pd.read_csv("C:/Users/tenin/Documents/BIMS/papier tick/Climate model/canada/Final_temp_can.csv", sep=";") 
df.head()
df.info()
df['date'] = df['date'].apply(dateutil.parser.parse, dayfirst=True)
df.head()
df.info()
df.tail()
df['days_since'] = (pd.to_datetime('2018-12-16')-df.date ).astype('timedelta64[D]')
df.head()
X = df['days_since']
Y=df['Mtemp']
X
mod = PolynomialModel(3)
pars = mod.guess(Y, x=X)
out = mod.fit(Y, pars, x=X)
print(out.fit_report(min_correl=0.25))
plt.plot(X, Y, 'b')
plt.plot(X, out.best_fit, 'k--', label='fitted line')
plt.show()
out
df.set_index("date", inplace = True)
upsampled = df.resample('D')
print(upsampled)
interpolated = upsampled.interpolate(method='polynomial',order=3)
print(interpolated.head(32))
interpolated.info()
df.reset_index( inplace=True)
df.info()
interpolated.reset_index( inplace=True)
interpolated.head()
Tmean= interpolated['Mtemp']
date=interpolated['date']
header = ["date", "Mtemp"]
interpolated.to_csv('daily_canada.csv', columns = header, index=False)
