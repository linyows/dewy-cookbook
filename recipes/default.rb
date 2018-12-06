# Cookbook Name:: dewy
# Recipe:: default

include_recipe 'dewy::install'
include_recipe 'dewy::setup' if node['dewy']['command'] =~ /^server/
