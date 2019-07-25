# frozen_string_literal: true

# Controller for our blogs application
class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :toggle_status]
  layout 'blog'
  access all: [:show, :index],
         user: { except: [:new, :edit, :create, :update, :destroy, :toggle_status] },
         site_admin: :all

  # GET /blogs
  # GET /blogs.json
  def index
    blog_scope = if logged_in? :site_admin
                   Blog
                 else
                   Blog.published_blogs
                 end
    @blogs = blog_scope.page(params[:page]).per(5)
    @page_title = 'Assorted Musings - Blog by A Lloyd Flanagan'

    @topic_list = topic_list
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    blog_scope = if logged_in? :site_admin
                   Blog
                 else
                   Blog.published_blogs
                 end
    @blog = blog_scope.includes(:comments).friendly.find(params[:id])
    @comment = Comment.new # empty comment for form

    @page_title = @blog.title
    # add keywords as field in blog model
    @seo_keywords = @blog.body

    @topic_list = topic_list
  end

  # GET /blogs/new
  def new
    site_admin_only do
      @blog = Blog.new
      @topic_list = topic_list
    end
  end

  # GET /blogs/1/edit
  def edit
    site_admin_only do
      @blog = Blog.friendly.find(params[:id])
      @topic_list = topic_list
    end
  end

  # POST /blogs
  # POST /blogs.json
  def create
    site_admin_only do
      @blog = Blog.new(blog_params)
      @topic_list = topic_list
      respond_to do |format|
        if @blog.save
          format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    site_admin_only do
      respond_to do |format|
        if @blog.update(blog_params)
          format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    site_admin_only do
      @blog.destroy
      respond_to do |format|
        format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      end
    end
  end

  # GET /blogs/1/toggle_status
  def toggle_status
    site_admin_only do
      if @blog.draft?
        @blog.published!
      else
        @blog.draft!
      end
      redirect_to blogs_url, notice: 'post status has been updated'
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :body, :topic_id)
    end

    def site_admin_only(&_)
      if logged_in? :site_admin
        yield
      else
        render status: :unauthorized
      end
    end

    def topic_list
      the_list = {}
      Topic.published.each do |topic|
        the_list[topic] = []
        topic.blogs.each do |blog|
          the_list[topic] << blog
        end
      end
      the_list
    end
end
