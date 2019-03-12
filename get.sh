#!/bin/bash

function getGithubTrending() {
    trendingUrl="https://github.com/trending/${1}?since=daily"
    curl -s "${trendingUrl}" -o tmp.html

    # get description
    cat tmp.html | sed -n  '/<ol class="repo-list/,/<\/ol>/p' | sed -n '/<p class=/,/<\/p>/p'  | sed '/<p class=/d;/<\/p>/d;/^[[:space:]]*$/d' | sed 's/^[[:space:]]*//' > description.txt

    # get name
    cat tmp.html | sed -n  '/<ol class="repo-list/,/<\/ol>/p' | sed -n '/<h3>/,/<\/h3>/p' | grep 'href="/'  | sed 's#.*<a href="/##;s#">##' | awk '{ print "1. ["$0"](https://github.com/"$0") : " }' | sed 's#/# / **#;s#]#** ]#' > name.txt

    paste -d ' ' name.txt description.txt >>  ${fileName}
    rm tmp.html name.txt description.txt
}


dateTime=$(date +"%Y-%m-%d")
fileName="${dateTime}.md"
echo "## ${dateTime}" >> ${fileName}


for languageName in '' javascript python go html shell
do
    echo "\n### ${languageName}" >>  ${fileName}
    getGithubTrending ${languageName}
    sleep 3
done

date +"%Y%m%d" >> log.txt

git add ${fileName}
git commit -m "${fileName}"
git push
