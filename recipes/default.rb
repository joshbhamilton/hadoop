#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "java"

execute "apt-get update" do
  action :nothing
end

package "curl"

execute "download cdh4" do
  command "curl -o cdh4-repository_1.0_all.deb http://archive.cloudera.com/cdh4/one-click-install/lucid/amd64/cdh4-repository_1.0_all.deb"
  action :run
end

execute "install cdh4 package" do
  command "dpkg -i cdh4-repository_1.0_all.deb"
  action :run
end

template "/etc/apt/sources.list.d/cloudera.list" do
  owner "root"
  mode "0644"
  source "cloudera.list.erb"
  notifies :run, resources("execute[apt-get update]"), :immediately
end

execute "curl -s http://archive.cloudera.com/debian/archive.key | apt-key add -" do
  not_if "apt-key export 'Cloudera Apt Repository'"
end

execute "apt-get update" do
  action :nothing
end

package "hadoop-0.20-conf-pseudo"

template "/etc/hadoop/conf/hadoop-env.sh" do
  owner "root"
  mode "0644"
  source "hadoop-env.sh"
end

execute "namemode -format" do
  command "sudo -u hdfs hdfs namenode -format"
  action :run
end

execute "start hdfs" do
  command "for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do sudo service $x start ; done"
  action :run
end

execute "sudo -u hdfs hadoop fs -mkdir /tmp"
execute "sudo -u hdfs hadoop fs -chmod -R 1777 /tmp"

execute "sudo -u hdfs hadoop fs -mkdir -p /var/lib/hadoop-hdfs/cache/mapred/mapred/staging"
execute "sudo -u hdfs hadoop fs -chmod 1777 /var/lib/hadoop-hdfs/cache/mapred/mapred/staging"
execute "sudo -u hdfs hadoop fs -chown -R mapred /var/lib/hadoop-hdfs/cache/mapred"

execute "start mapreduce" do
  command "for x in `cd /etc/init.d ; ls hadoop-0.20-mapreduce-*` ; do sudo service $x start ; done"
  action :run
end

execute "create hdfs dir" do
  command "sudo -u hdfs hadoop fs -mkdir /user/vagrant"
  action :run
end
execute "sudo -u hdfs hadoop fs -chown vagrant /user/vagrant"
execute "sudo -u vagrant hadoop fs -mkdir input"