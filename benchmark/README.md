# Benchmark

To ensure migration's liveliness as proposed, we would need to ensure its availability

## Siege

To install Siege, run these commands:

```shell
git clone https://github.com/JoeDog/siege.git
cd siege
sudo apt-get update
sudo apt-get install autoconf automake libtool
utils/bootstrap
./configure
make
sudo make install
```

then, run these to do benchmarking after running `migrate.sh`:

```shell
siege -v -t 2M -c 10 -d 30S http://url
```

these command variables mean running Siege Test with 10 concurrent users, each perform transaction in a random time of 1 to 30 seconds over duration of 2 minutes on http://url

result as follow:

```shell
        "transactions":                          225,
        "availability":                       100.00,
        "elapsed_time":                       119.35,
        "data_transferred":                     1.45,
        "response_time":                        0.47,
        "transaction_rate":                     1.89,
        "throughput":                           0.01,
        "concurrency":                          0.89,
        "successful_transactions":               225,
        "failed_transactions":                     0,
        "longest_transaction":                  0.68,
        "shortest_transaction":                 0.42
```

As we can see, availability is 100% during migration indicating zero downtime live migration was successful

```shell
"migration_result.stdout_lines": [
        "PREDUMP",
        "mysql: predump finished after 0.37 second(s) with exit code 0",
        "mysql: predump size 128M\t/home/ubuntu/mysql/predump",
        "",
        "wordpress: predump finished after 1.62 second(s) with exit code 0",
        "wordpress: predump size 98M\t/home/ubuntu/wordpress/predump",
        "",
        "PREDUMP TRANSFER",
        "wordpress: total size (container + predump) 713M\t/home/ubuntu/wordpress",
        "",
        "wordpress: transferring predump to 10.0.1.3::/home/ubuntu/wordpress",
        "mysql: total size (container + predump) 828M\t/home/ubuntu/mysql",
        "",
        "mysql: transferring predump to 10.0.1.3::/home/ubuntu/mysql",
        "wordpress: predump transfer time 7.88 seconds",
        "mysql: predump transfer time 9.33 seconds",
        "CHECKPOINT",
        "No such backend.",
        "",
        "No such backend.",
        "",
        "mysql: checkpoint finished after 0.34 second(s) with exit code 0",
        "mysql: checkpoint size 1.7M\t/home/ubuntu/mysql/checkpoint",
        "",
        "wordpress: checkpoint finished after 0.47 second(s) with exit code 0",
        "wordpress: checkpoint size 17M\t/home/ubuntu/wordpress/checkpoint",
        "",
        "CALCULATE",
        "mysql: evaluating checkpoint transfer size",
        "wordpress: evaluating checkpoint transfer size",
        "mysql: total checkpoint transfer size 1555869 bytes",
        "mysql: checkpoint transfer size calculation time 0.28 seconds",
        "wordpress: total checkpoint transfer size 17525652 bytes",
        "wordpress: checkpoint transfer size calculation time 0.38 seconds",
        "CHECKPOINT TRANSFER + NOTIFY",
        "Starting transfer of wordpress",
        "Waiting for transfer of wordpress",
        "wordpress: transferring checkpoint to 10.0.1.3::/home/ubuntu/wordpress",
        "Starting transfer of mysql",
        "Waiting for transfer of mysql",
        "mysql: transferring checkpoint to 10.0.1.3::/home/ubuntu/mysql",
        "mysql: checkpoint transfer time 0.67 seconds",
        "wordpress: checkpoint transfer time 0.90 seconds",
        "mysql: runc restored mysql successfully",
        "wordpress: runc restored wordpress successfully",
        "mysql: target notification time 5.60 seconds",
        "wordpress: target notification time 5.81 seconds",
        "Total downtime: 7.60 second(s)"
    ]
```