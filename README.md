Description
===========

This is a modification of the [Opscode Hadoop recipe](https://github.com/opscode-cookbooks/hadoop).

Installs Apache Hadoop and sets up a pseudo-distributed configuration. Used primarily with Vagrant setup.

Requirements
============

## Platform:

* Debian/Ubuntu

Tested on Ubuntu 10.04, though should work on most Linux distributions.

## Cookbooks:

* apt
* java

Usage
=====


This cookbook will install Cloudera's CDH4 following the instructions [here](http://www.cloudera.com/content/cloudera-content/cloudera-docs/CDH4/latest/CDH4-Quick-Start/cdh4qs_topic_3_3.html).

This will install Hadoop and configure it to run in Pseudo-distributed mode. The filesystem has been formatted and is ready to start executing MapReduce jobs.

License and Author
==================

Author:: Joshua Timberman (<joshua@opscode.com>)

Copyright:: 2009, Opscode, Inc


you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
