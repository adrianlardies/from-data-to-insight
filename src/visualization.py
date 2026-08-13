import matplotlib.pyplot as plt
import pandas as pd


# Función para generar la visualización de la consulta 1
def plot_growth_comparison(df):
    plt.figure(figsize=(12, 8))

    # Gráfico de líneas para cada activo
    plt.plot(df['year'], df['bitcoin_growth'], label='Crecimiento Bitcoin', marker='o', linestyle='-', color='orange')
    plt.plot(df['year'], df['gold_growth'], label='Crecimiento Oro', marker='s', linestyle='-', color='gold')
    plt.plot(df['year'], df['sp500_growth'], label='Crecimiento S&P 500', marker='^', linestyle='-', color='blue')

    # Títulos y etiquetas
    plt.title('Crecimiento Anual de Bitcoin, Oro y S&P 500 (2015-2024)', fontsize=16, fontweight='bold')
    plt.xlabel('Año', fontsize=14)
    plt.ylabel('Crecimiento (%)', fontsize=14)

    # Leyenda
    plt.legend(title='Activos', title_fontsize='13', fontsize='12')

    # Añadir etiquetas de datos
    for i in range(len(df)):
        if pd.notna(df['bitcoin_growth'][i]):
            plt.text(df['year'][i], df['bitcoin_growth'][i], f"{df['bitcoin_growth'][i]:.2f}%", fontsize=10, ha='center', color='orange')
        if pd.notna(df['gold_growth'][i]):
            plt.text(df['year'][i], df['gold_growth'][i], f"{df['gold_growth'][i]:.2f}%", fontsize=10, ha='center', color='gold')
        if pd.notna(df['sp500_growth'][i]):
            plt.text(df['year'][i], df['sp500_growth'][i], f"{df['sp500_growth'][i]:.2f}%", fontsize=10, ha='center', color='blue')

    # Estilo de cuadrícula
    plt.grid(True, linestyle='--', alpha=0.6)

    # Mostrar gráfico
    plt.tight_layout()
    plt.show()


# Función para generar la visualización de la consulta 4
def plot_sp500_inflation(df):
    fig, ax1 = plt.subplots(figsize=(12, 8))

    # Gráfico de líneas para el crecimiento del S&P 500
    ax1.plot(df['year'], df['sp500_growth'], color='blue', marker='o', label='Crecimiento S&P 500')
    ax1.set_xlabel('Año', fontsize=14)
    ax1.set_ylabel('Crecimiento del S&P 500 (%)', color='blue', fontsize=14)
    ax1.tick_params(axis='y', labelcolor='blue')

    # Añadir etiquetas de datos en el gráfico de S&P 500
    for i in range(len(df)):
        if pd.notna(df['sp500_growth'][i]):
            ax1.text(df['year'][i], df['sp500_growth'][i], f"{df['sp500_growth'][i]:.2f}%", fontsize=10, ha='center', color='blue')

    # Crear un segundo eje Y para la inflación
    ax2 = ax1.twinx()
    ax2.plot(df['year'], df['avg_inflation'], color='red', marker='s', label='Inflación Promedio')
    ax2.set_ylabel('Inflación Promedio (%)', color='red', fontsize=14)
    ax2.tick_params(axis='y', labelcolor='red')

    # Añadir etiquetas de datos en el gráfico de inflación
    for i in range(len(df)):
        if pd.notna(df['avg_inflation'][i]):
            ax2.text(df['year'][i], df['avg_inflation'][i], f"{df['avg_inflation'][i]:.2f}%", fontsize=10, ha='center', color='red')

    # Título
    plt.title('Crecimiento del S&P 500 y su Relación con la Inflación (2015-2024)', fontsize=16, fontweight='bold')

    # Leyendas
    ax1.legend(loc='upper left')
    ax2.legend(loc='upper right')

    # Cuadrícula
    ax1.grid(True, linestyle='--', alpha=0.6)

    # Mostrar gráfico
    plt.tight_layout()
    plt.show()