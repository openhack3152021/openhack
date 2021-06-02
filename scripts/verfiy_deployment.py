
import requests
import time
from datetime import datetime, timedelta


TIMEOUT = 600
headers = {"Accept": "application/vnd.github.v3+json"}
start_utc = datetime.utcnow()
TITLE = "API Response time Degredation"
since_format = start_utc.strftime("%Y-%m-%dT%H:%M:%SZ")
URL = f"https://api.github.com/repos/openhack3152021/openhack/issues?since={since_format}"
RUNNING = True
data = []
while RUNNING:
    res = requests.get(url=URL, headers=headers)
    if res.status_code == 200:
        data = res.json()

    if len(data) > 0:
        print("Found issues, filtering")
        for item in data:
            if item.get("title") == TITLE:
                print("Issue Found, break out")
                print(item)
                exit(1)

    current_time = datetime.utcnow()
    time_spend = current_time - start_utc
    if time_spend.seconds > TIMEOUT:
        print("Got timeout")
        RUNNING = False

print("No issues found")
exit(0)