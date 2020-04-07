module ApplicationHelper
    # Возвращает полный заголовок для каждой страницы
    def full_title(page_title = '')
        base_title = "SplutterApp"
        if page_title.empty?
            base_title
        else 
            page_title + " | " + base_title
        end
    end
end
