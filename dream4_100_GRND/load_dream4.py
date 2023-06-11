
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os
from glob import glob
from tqdm import tqdm
from sklearn.preprocessing import MinMaxScaler, StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.decomposition import PCA
from sklearn.pipeline import Pipeline

#these should be set by DreamEncoder4_Official 
NUM_REPLICATES = None
NUM_TIME_STEPS = None
NUM_TARGETS = None 
NUM_PARENTS = None

def fix_dataset(dirty_regulations):
    dirtyReg = pd.read_csv(dirty_regulations,  index_col = 0,)# on_bad_lines='skip')
    dirtyReg = dirtyReg.dropna(axis=0)
    dirtyReg = dirtyReg.select_dtypes(include=np.number)
    dirtyReg = dirtyReg.to_numpy() #reshape would not work in this case. 

    dRegs = np.zeros(shape=(NUM_REPLICATES, NUM_TIME_STEPS, NUM_TARGETS), dtype=np.float)
    for i in range(NUM_REPLICATES):
        dRegs[i] = dirtyReg[NUM_TIME_STEPS*i : NUM_TIME_STEPS*(i+1)]
    dRegs.shape

    ds = dRegs
    ret = np.zeros(shape=(NUM_REPLICATES,NUM_TIME_STEPS, NUM_TARGETS))

    # for i in range(0,NUM_REPLICATES*NUM_TIME_STEPS, 4):
    #     for j in range(0, NUM_REPLICATES):
    #         dataset[j][:,i//NUM_REPLICATES] = dirtyR[:,(i+j)]
    
    ds[ds==0.0] = np.nan #we do this so the scaling ignores 0.0 #CHECKED


    for i in range(NUM_REPLICATES):
        regScaled = StandardScaler().fit_transform(ds[i].flatten().reshape((-1,1)))
        regScaled = MinMaxScaler().fit_transform(ds[i].flatten().reshape((-1,1))) #ignores np.nan
        regScaled = regScaled.reshape((NUM_TARGETS, NUM_TIME_STEPS))
        regScaled = np.nan_to_num(regScaled, nan= 0.0)
        ret[i] = regScaled.T
    return ret


def prep_goldStandard(gold):
    def keep_numeric(df):

        return df.applymap(lambda x: ''.join(filter(str.isdigit, str(x))) if isinstance(x, (int,float)) else ''.join(filter(str.isdigit, x)) )

    gold = keep_numeric(gold)
    goldnp = np.array(gold, dtype = 'int')
    #subtract 1 from each index to match python index
    goldnp[:,0] = goldnp[:,0] - 1
    goldnp[:,1] = goldnp[:,1] - 1

    goldIm = np.zeros(shape=(NUM_TARGETS,NUM_TARGETS))

    for g in goldnp:
        reg = g[0]
        tar = g[1]
        connection = g[2]
        goldIm[reg][tar] = connection

    return gold, goldIm