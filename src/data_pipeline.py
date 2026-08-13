import os

import pandas as pd
from sqlalchemy import URL, create_engine

# Función para leer el CSV y retornar el DataFrame
def load_csv(file_path):
    return pd.read_csv(file_path)

# Función para configurar la conexión a la base de datos
def create_db_connection(
    password=None,
    user=None,
    host=None,
    port=None,
    database=None,
):
    connection_url = URL.create(
        drivername="mysql+pymysql",
        username=user or os.getenv("MYSQL_USER", "root"),
        password=password if password is not None else os.getenv("MYSQL_PASSWORD"),
        host=host or os.getenv("MYSQL_HOST", "localhost"),
        port=int(port or os.getenv("MYSQL_PORT", "3306")),
        database=database or os.getenv("MYSQL_DATABASE", "financial_analysis"),
    )
    return create_engine(connection_url)

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
