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
    years = [2020]
    months = [10, 11, 12]

    #Initialize the df
    df = pd.DataFrame()

    #Parse date types
    taxi_dtypes = {
        'VendorID': pd.Int64Dtype(),
        'passenger_count': pd.Int64Dtype(),
        'trip_distance': float,
        'RatecodeID': pd.Int64Dtype(),
        'store_and_fwd_flag': str,
        'PULocationID': pd.Int64Dtype(),
        'DOLocationID': pd.Int64Dtype(),
        'payment_type': pd.Int64Dtype(),
        'fare_amount': float,
        'extra': float,
        'mta_tax': float,
        'tip_amount': float,
        'tolls_amount': float,
        'improvement_surcharge': float,
        'total_amount': float,
        'congestion_surcharge': float 
    }

    parse_dates = ['lpep_pickup_datetime', 'lpep_dropoff_datetime']

    #Cicle through the year/months and concatenate each file to the initialized df
    for year in years:
        for month in months:
            url = f"https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_{year}-{month}.csv.gz"
            df_1 = pd.read_csv(url, sep=",", compression="gzip", dtype=taxi_dtypes, parse_dates=parse_dates)
            df = pd.concat([df, df_1])

    return df


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
