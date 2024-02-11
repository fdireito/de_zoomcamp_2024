import pandas as pd

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data(*args, **kwargs):
    """
    Template code for loading data from any source.

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    # Specify years and months we want to visualize the data on
    years = [2022]
    months = ['01', '02', '03', '04', '05', '06', '07', '08' , '09', '10', '11', '12']

    #Initialize the df
    df = pd.DataFrame()

    #Cicle through the year/months and concatenate each file to the initialized df
    for year in years:
        for month in months:
            url = f"https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_{year}-{month}.parquet"
            df_1 = pd.read_parquet(url)
            df = pd.concat([df, df_1])

    return df


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
