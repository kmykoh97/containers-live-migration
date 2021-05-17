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