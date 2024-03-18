
@transformer
def transform(data, *args, **kwargs):
    data.columns = (data.columns
                    .str.replace(' ','_')
                    .str.lower()
    )

    return data
