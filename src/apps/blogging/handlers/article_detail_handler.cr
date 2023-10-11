module Blogging
  class ArticleDetailHandler < Marten::Handlers::RecordDetail
    model Article
    template_name "blogging/article_detail.html"
    lookup_field :slug
    record_context_name :article

    def context
      ctx = super

      if request.user? && record.author != request.user!.profile
        ctx[:following] = request.user!.profile!.followed_users.exists?(pk: record.author_id)
      end

      ctx
    end
  end
end
