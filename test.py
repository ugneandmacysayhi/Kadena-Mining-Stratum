import requests
import urllib3
urllib3.disable_warnings()
req = requests.get(
                'https://kadena1.icemining.ca/chainweb/0.0/mainnet01/mining/work?chain=0',
                json={
                    'account': '98d4ad2ee100f9c690a625789e4406677a5357f1bfaaad0bcfbbd6c2ff55b9da',
                    'public-keys': ["98d4ad2ee100f9c690a625789e4406677a5357f1bfaaad0bcfbbd6c2ff55b9da"],
                    'predicate': "keys-all"
                },
                verify=False, timeout=15)
data = req.content
print data
