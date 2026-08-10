def clear_data (dataf: pd.Series) -> pd.Series:
    dataf = dataf.str.strip()
    return dataf