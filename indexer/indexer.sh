function printGreen() {
    printf "\e[0;32m$1\e[0;m\n"
}

function printRed() {
    printf "\e[0;31m$1\e[0;m\n"
}

service=$1

if ! [[ "$service" =~ ^(create|add)$ ]]; then
    printRed "Incorrect service: $service"
    exit 1
fi

indexDir=./blacklab-data
 
java -cp "./WEB-INF/lib/*" nl.inl.blacklab.tools.IndexTool $service $indexDir ./tei-data/ ./formats/ptt.blf.yaml

printGreen "Blacklab indexes generated: ${indexDir}"