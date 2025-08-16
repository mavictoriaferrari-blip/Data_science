import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns




x=['EDA','Data Wrangling','Mineria datos','Limpieza Datos','SQL','Est. Inferencial','ML','DL','IA']
y= [5,10,15,20,30,25,31,30,20] 

data = {
    "Conocimientos previos":x,
    "Frecuencia": y
}

dataset = pd.DataFrame(data)
dataset



# Visualizar los datos
plt.figure(figsize=(16, 9))
sns.set_style("darkgrid")
ax = sns.barplot(x="Conocimientos previos", y='Frecuencia', data=dataset)
plt.title('Importancia de Habilidades en Data Science', fontsize=16)
plt.xlabel('Habilidad', fontsize=12)
plt.ylabel('Nivel de Importancia', fontsize=12)
plt.xticks(rotation=45, ha='right')
plt.tight_layout()

# Añadir etiquetas de valor en cada barra
for i, v in enumerate(dataset['Frecuencia']):
    ax.text(i, v + 0.5, str(v), ha='center', fontsize=10)

plt.show()

plt.savefig("counter_freq.png")
