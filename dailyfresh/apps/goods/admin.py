from django.contrib import admin
from django.core.cache import cache

# Register your models here.

from goods.models import GoodsCategory, Goods, GoodsSKU, GoodsImage
from goods.models import IndexGoodsBanner, IndexCategoryGoodsBanner, IndexPromotionBanner


class BaseModelAdmin(admin.ModelAdmin):
    def save_model(self, request, obj, form, change):
        obj.save()
        from celery_tasks.tasks import generate_static_index_html
        generate_static_index_html.delay()
        cache.delete("index_page")

    def delete_model(self, request, obj):
        obj.delete()
        from celery_tasks.tasks import generate_static_index_html
        generate_static_index_html.delay()
        cache.delete("index_page")


class GoodsCategoryAdmin(BaseModelAdmin):
    pass


class IndexGoodsBannerAdmin(BaseModelAdmin):
    pass


class IndexCategoryGoodsBannerAdmin(BaseModelAdmin):
    pass


class IndexPromotionBannerAdmin(BaseModelAdmin):
    pass


admin.site.register(GoodsCategory, GoodsCategoryAdmin)
admin.site.register(Goods)
admin.site.register(GoodsSKU)
admin.site.register(GoodsImage)
admin.site.register(IndexGoodsBanner, IndexGoodsBannerAdmin)
admin.site.register(IndexCategoryGoodsBanner, IndexCategoryGoodsBannerAdmin)
admin.site.register(IndexPromotionBanner, IndexPromotionBannerAdmin)
