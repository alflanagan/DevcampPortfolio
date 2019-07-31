# frozen_string_literal: true

# Controller for our blogs application
class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :toggle_status]
  before_action :set_sidebar_topics, except: [:update, :create, :destroy, :toggle_status]

  layout 'blog'
  access all: [:show, :index],
         user: { except: [:new, :edit, :create, :update, :destroy, :toggle_status] },
         site_admin: :all

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = (if logged_in? :site_admin
                Blog
              else
                Blog.published
              end).recent.page(params[:page]).per(5)
    @page_title = 'Assorted Musings - Blog by A Lloyd Flanagan'
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    if logged_in?(:site_admin) || @blog.published?
      @blog = Blog.includes(:comments).friendly.find(params[:id])
      @comment = Comment.new # empty comment for form

      @page_title = @blog.title
      # add keywords as field in blog model
      @seo_keywords = @blog.body
    else
      redirect_to blogs_path, notice: 'You are not authorized to access that page'
    end
  end

  # GET /blogs/new
  def new
    if logged_in?(:site_admin)
      @blog = Blog.new
    else
      redirect_to blogs_path, notice: 'You are not authorized to create a blog entry'
    end
  end

  # GET /blogs/1/edit
  def edit
    unless logged_in? :site_admin
      redirect_to blogs_path, notice: 'You are not authorized to edit a blog post'
    end
  end

  # POST /blogs
  # POST /blogs.json
  def create
    if logged_in? :site_admin
      @blog = Blog.new(blog_params)

      respond_to do |format|
        if @blog.save
          format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        else
          format.html { render :new }
        end
      end
    else
      redirect_to blogs_path, notice: 'You are not authorized to create a post'
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    if logged_in? :site_admin
      respond_to do |format|
        if @blog.update(blog_params)
          format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    else
      redirect_to blog_path, notice: 'You are not authorized to update a blog post'
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    if logged_in? :site_admin
      @blog.destroy
      respond_to do |format|
        format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      end
    else
      redirect_to blog_path, 'You are not authorized to destroy a blog post'
    end
  end

  # GET /blogs/1/toggle_status
  def toggle_status
    if logged_in? :site_admin
      if @blog.draft?
        @blog.published!
      else
        @blog.draft!
      end
      redirect_to blogs_url, notice: 'post status has been updated'
    else
      redirect_to blogs_path, notice: 'You are not authorized to publish posts'
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

    def set_sidebar_topics
      @side_bar_topics = Topic.with_blogs
    end
end
