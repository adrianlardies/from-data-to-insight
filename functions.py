import pandas as pd
from sqlalchemy import create_engine
import matplotlib.pyplot as plt
import seaborn as sns

# Función para leer el CSV y retornar el DataFrame
def load_csv(file_path):
    return pd.read_csv(file_path)

# Función para configurar la conexión a la base de datos
def create_db_connection(password, db_name="financial_analysis"):
    connection_string = f'mysql+pymysql://root:{password}@localhost/{db_name}'
    engine = create_engine(connection_string)
    return engine

# Función para insertar fechas en la tabla 'dates'
def insert_dates(df, engine):
    df_dates = pd.DataFrame(df['date'].unique(), columns=['date'])
    df_dates.to_sql('dates', con=engine, if_exists='append', index=False)
    return df_dates

# Función para obtener las fechas desde la base de datos y realizar el merge
def merge_dates(df, engine):
    # Leer las fechas desde la base de datos
    dates_from_db = pd.read_sql('SELECT * FROM dates', con=engine)
    
    # Asegurarse de que las fechas estén en el mismo formato
    df['date'] = pd.to_datetime(df['date']).dt.date
    dates_from_db['date'] = pd.to_datetime(dates_from_db['date']).dt.date
    
    # Realizar el merge entre el DataFrame original y las fechas desde la base de datos
    df_merged = pd.merge(df, dates_from_db, how='left', on='date')
    
    # Verificar si las columnas 'id_date_x' y 'id_date_y' existen
    if 'id_date_x' in df_merged.columns and 'id_date_y' in df_merged.columns:
        df_merged.drop(columns=['id_date_x'], inplace=True)
        df_merged.rename(columns={'id_date_y': 'id_date'}, inplace=True)
    elif 'id_date' in df_merged.columns:
        # Si la columna 'id_date' existe sin el sufijo '_x' o '_y', simplemente mantenerla
        pass
    
    return df_merged

# Función para dividir el DataFrame en 'assets' y 'economic_factors'
def split_and_insert_data(df_merged, engine):
    assets_df = df_merged[['id_date', 'price_bitcoin', 'price_gold', 'price_sp500', 'change_bitcoin', 'change_gold']]
    economic_factors_df = df_merged[['id_date', 'vix', 'interest_rate', 'cpi', 'inflation']]
    assets_df.to_sql('assets', con=engine, if_exists='append', index=False)
    economic_factors_df.to_sql('economic_factors', con=engine, if_exists='append', index=False)

# Función para ejecutar una consulta SQL y retornar el DataFrame
def execute_query(engine, query):
    return pd.read_sql(query, con=engine)

# Función para generar la visualización de la consulta 1
def plot_growth_comparison(df):
    plt.figure(figsize=(12, 8))
    plt.plot(df['year'], df['bitcoin_growth'], label='Crecimiento Bitcoin', marker='o', linestyle='-', color='orange')
    plt.plot(df['year'], df['gold_growth'], label='Crecimiento Oro', marker='s', linestyle='-', color='gold')
    plt.plot(df['year'], df['sp500_growth'], label='Crecimiento S&P 500', marker='^', linestyle='-', color='blue')
    plt.title('Crecimiento Anual de Bitcoin, Oro y S&P 500 (2015-2024)', fontsize=16, fontweight='bold')
    plt.xlabel('Año', fontsize=14)
    plt.ylabel('Crecimiento (%)', fontsize=14)
    plt.legend(title='Activos', title_fontsize='13', fontsize='12')
    plt.grid(True, linestyle='--', alpha=0.6)
    plt.tight_layout()
    plt.show()

# Función para generar la visualización de la consulta 4
def plot_sp500_inflation(df):
    fig, ax1 = plt.subplots(figsize=(12, 8))
    ax1.plot(df['year'], df['sp500_growth'], color='blue', marker='o', label='Crecimiento S&P 500')
    ax1.set_xlabel('Año', fontsize=14)
    ax1.set_ylabel('Crecimiento del S&P 500 (%)', color='blue', fontsize=14)
    ax2 = ax1.twinx()
    ax2.plot(df['year'], df['avg_inflation'], color='red', marker='s', label='Inflación Promedio')
    ax2.set_ylabel('Inflación Promedio (%)', color='red', fontsize=14)
    plt.title('Crecimiento del S&P 500 y su Relación con la Inflación (2015-2024)', fontsize=16, fontweight='bold')
    ax1.grid(True, linestyle='--', alpha=0.6)
    plt.tight_layout()
    plt.show()