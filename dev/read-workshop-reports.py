"""Read public Workshop comments; keep the original response outside Git."""
import html,json,re
from pathlib import Path
from urllib.request import Request,urlopen

root=Path(__file__).resolve().parents[1]
url='https://steamcommunity.com/comment/PublishedFile_Public/render/76561198042483215/3825999183/?start=0&count=100'
with urlopen(Request(url,headers={'Cache-Control':'no-cache','User-Agent':'Mozilla/5.0'}),timeout=45) as response:
    data=json.load(response)
out=root/'build/bug-reports-20261103';out.mkdir(parents=True,exist_ok=True)
(out/'comments.json').write_text(json.dumps(data,indent=2),'utf8')
text=re.sub(r'<(?:br|/div|/p)[^>]*>','\n',data['comments_html'])
text=html.unescape(re.sub(r'<[^>]+>','',text))
text='\n'.join(line.strip() for line in text.splitlines() if line.strip())
print('Public comments total:',data.get('total_count'))
print(text)
