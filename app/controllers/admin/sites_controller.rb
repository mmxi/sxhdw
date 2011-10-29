# encoding: utf-8
class Admin::SitesController < ApplicationController
  before_filter :require_user
  layout "admin"

  def index
    @sites = Site.all
  end

  def show
    @site = Site.find(params[:id])
  end

  def new
    @site = Site.new
    @page_title = "创建新站点"
  end

  def create
    @site = Site.new(params[:site])
    if @site.save
      flash[:success] = "新站点创建成功"
      redirect_to admin_sites_path
    else
      flash[:error] = "创建失败"
      redirect_to edit_admin_sites_path
    end
  end

  def edit
    @site = Site.find(params[:id])
    @page_title = "编辑站点"
  end

  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(params[:site])
      flash[:success] = "更新成功"
      redirect_to admin_site_path
    else
      flash[:error] = "更新失败"
      #redirect_to edit_admin_site_path
      render :edit
    end
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    redirect_to admin_sites_path
  end

  def set_default_site
    @site = Site.find(params[:id])
    Settings.current_site = @site.host
    redirect_to admin_sites_path
  end
end
