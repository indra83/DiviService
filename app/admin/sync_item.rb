ActiveAdmin.register SyncItem do
  controller do
    def per_page
      return max_per_page if request.format == 'text/csv'
      super
    end
  end
end
