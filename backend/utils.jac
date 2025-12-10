# Utility functions for date and time operations
 
import os;
import requests;
import from datetime {datetime, timedelta}
import from dotenv {load_dotenv}

# Load environment variables from .env file
glob env_loaded = load_dotenv();

# Date Time utility functions

def parse_date(date_str: str) -> datetime {
    # Common date formats
    formats = [
        "%Y-%m-%d", #2025-12-31
        "%d-%m-%Y", #31-12-2025
        "%m/%d/%Y", #12/31/2025
        "%Y/%m/%d", #2025/12/31
        "%d %b %Y", #31 Dec 2025
        "%d %B %Y"  #31 December 2025
    ];

    for fmt in formats {
        try {
            return datetime.strptime(date_str, fmt);
        } except ValueError {
            continue;
        }
    }

    # If no format matches, return current date as fallback
    return get_current_date();
}

def get_current_datetime() -> str {
    # Get current date and time in ISO 8601 format
    return datetime.now().isoformat();
}

def get_current_date() -> str {
    # Get current date in YYYY-MM-DD format
    return datetime.now().strftime("%Y-%m-%d");
}

def get_current_month() -> str {
    # Get current month in YYYY-MM format
    return datetime.now().strftime("%Y-%m");
}

def get_current_time() -> str {
    # Get current time in HH:MM:SS format
    return datetime.now().strftime("%H:%M:%S");
}

def month_range(year: int, month: int) -> (str, str) {
    # Get the start and end date of a given month
    start_date = datetime(year, month, 1);
    if month == 12 {
        end_date = datetime(year + 1, 1, 1) - timedelta(days=1);
    } else {
        end_date = datetime(year, month + 1, 1) - timedelta(days=1);
    }
    return {
        "start_date": start_date.strftime("%Y-%m-%d"),
        "end_date": end_date.strftime("%Y-%m-%d")
    };
}

def get_last_n_months(n: int) -> list {
    # Get a list of the last n months in 'YYYY-MM' format
    months = [];
    today = datetime.now();
    for i in range(n) {
        month = today.strftime("%Y-%m");
        today = datetime.now();
        months.append(month);

        # Go back one month
        if today.month == 1 {
            today = datetime(today.year - 1, 12, 1);
        } else {
            today = datetime(today.year, today.month - 1, 1);
        }
    }

    # Return months in chronological order
    months = months.reverse();
    return months;
}

def is_date_in_range(date_str: str, start_str: str, end_str: str) -> bool {
    # Check if a date is within a given range
    try {
        date = parse_date(date_str);
        start_date = parse_date(start_str);
        end_date = parse_date(end_str);
        return start_date <= date <= end_date;
    } except ValueError {
        return False;
    }
}





