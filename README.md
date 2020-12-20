# Live Migration Of Containerized Applications

I try to move networking application containers across cloud hosts in minimal downtime(preferably zero!). Several knowledge prerequisite needed to do this. Ie, precopy, postcopy, networking, container, VPN, linux...

## Introduction

Live migration is the movement of a system or application from one physical host to another while continuously powered-up. When properly carried out, this process takes place without any noticeable effect from the point of view of the end user. In our case of containerized application, we want to make sure our network remain intact the whole time during migration. Users might experience delay but in no way the service is down.

## Steps

- [x] [local test migration]()
- [x] [Infrastructure set up and management]()
- [x] [Installing development tools]()
- [ ] [Setting up VPN secure tunnel]()
- [ ] [Installing migration tools]()
- [ ] [Setting up containers]()
- [ ] [Begin migration]()
- [ ] [Finishing touches]()
