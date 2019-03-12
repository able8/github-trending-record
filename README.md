# Github Trending Record (Shell)
Record the most popular Github repos, update daily(Shell version)

inspired by [github-trending(Python Version)](https://github.com/bonfy/github-trending)


## Run

add a cron job `crontab -e`

```bash
0 12 * * * cd yourdir; /bin/bash get.sh
```

## Advance

A better place to use the script is in VPS

* You should have a VPS first, and then you should Add SSH Keys of your VPS to Github

* Then you can run the code in VPS

Thus the code will run never stop

## Lisence

MIT
