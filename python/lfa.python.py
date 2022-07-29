# This script was produced by glue and can be used to further customize a
# particular plot.

### Package imports

from glue.core.state import load

import matplotlib

import matplotlib.pyplot as plt

import numpy as np

matplotlib.use('Agg')

# matplotlib.use('qt5Agg')

### Set up data

data_collection = load('make_plot.py.data')

### Set up viewer

# Initialize figure
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1, aspect='auto', projection='rectilinear')

# for the legend
legend_handles = []
legend_labels = []
legend_handler_dict = dict()

### Set up layers

## Layer 1: navablfacsv_norm

layer_data = data_collection[0]

layer_handles = []  # for legend# Get main data values
x = layer_data['WELLNUM']
y = layer_data['E04']
keep = ~np.isnan(x) & ~np.isnan(y)

plot_artists = ax.plot(x[keep], y[keep], 'o', color='#ff0000', markersize=15.744223807493176, alpha=0.8, zorder=1, label='navablfacsv_norm', mec='none')
layer_handles.extend(plot_artists)

legend_handles.append(tuple(layer_handles))
legend_labels.append(layer_data.label)

### Legend

# ax.legend(legend_handles, legend_labels,
#     handler_map=legend_handler_dict,
#     loc='best',            # location
#     framealpha=0.59,      # opacity of the frame
#     title='',             # title of the legend
#     title_fontsize=10,   # fontsize of the title
#     fontsize=10,          # fontsize of the labels
#     facecolor='#FFFFFF',
#     edgecolor=(0.0, 0.0, 0.0, 0.5858585858585859)
# )

### Finalize viewer

# Set limits
ax.set_xlim(left=0.3301440922190202, right=42.45014409221902)
ax.set_ylim(bottom=0.047848683999732335, top=1.109035307895747)


# Set scale (log or linear)
ax.set_xscale('linear')
ax.set_yscale('log')


# Set axis label properties
ax.set_xlabel('WELLNUM', weight='normal', size=10)
ax.set_ylabel('Log E04', weight='normal', size=10)

# Set tick label properties
ax.tick_params('x', labelsize=8)
ax.tick_params('y', labelsize=8)

# For manual edition of the plot
#  - Uncomment the next code line (plt.show)
#  - Also change the matplotlib backend to qt5Agg
#  - And comment the "plt.close" line
# plt.show()

# Save figure
fig.savefig('glue_plot.png')
plt.close(fig)