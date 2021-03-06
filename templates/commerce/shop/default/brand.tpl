{# Variables
# @var model
# @var jsCode
# @var products
# @var totalProducts
# @var brandsInCategory
# @var pagination
# @var cart_data
#}

{$forCompareProducts = $CI->session->userdata('shopForCompare')}

<div class="content">
    <div class="center">
        <div class="catalog_content">
            <div class="catalog_frame">
                <div class="box_title clearfix">
                    <div class="f-s_24 f_l">{echo ShopCore::encode($model->getName())} <span class="count_search">({$totalProducts})</span></div>
                    <div class="f_r">
                     {echo $model->getDescription()}
                    </div>
                </div>
                 <ul>
                    <!--  Render produts list   -->
                    {foreach $products as $product}
                    {$style = productInCart($cart_data, $product->getId(), $product->firstVariant->getId(), $product->firstVariant->getStock())}
                    <li {if $product->firstvariant->getstock()== 0}class="not_avail"{/if}>
                        <div class="photo_block">
                            <a href="{shop_url('product/' . $product->getUrl())}">
                                <img src="{productImageUrl($product->getMainModimage())}" alt="{echo ShopCore::encode($product->name)}" />
                            </a>
                        </div>
                        <div class="func_description">
                            <a href="{shop_url('product/' . $product->getUrl())}" class="title">{echo ShopCore::encode($product->name)}</a>
                            <div class="f-s_0">
                                <!--    Show Product Number -->
                                    {if $product->firstVariant->getNumber()}<span class="code">Код {echo ShopCore::encode($product->firstVariant->getNumber())}</span>{/if}
                                <!--    Show Product Number -->

                                <!--<div class="di_b star"><img src="{$SHOP_THEME}images/temp/STAR.png"></div>-->

                                <!--    Show Comments count -->
                                    <a href="{shop_url('product/'.$product->getId().'?cmn=on')}"  class="response">
                                        {echo $product->totalComments()} {echo SStringHelper::Pluralize($product->totalComments(), array('отзыв', 'отзывы', 'отзывов'))}</a>
                                <!--    Show Comments count -->

                            </div>
                            <div class="f_l">
                                <div class="buy">
                                    <div class="price f-s_18 f_l">{echo $product->firstVariant->toCurrency()} 
                                        <sub>{$CS}</sub>
                                        {if $NextCS != $CS}
                                        <span class="d_b">{echo $product->firstVariant->toCurrency('Price', $NextCSId)} {$NextCS}</span>
                                        {/if}
                                    </div>
                                    <div class="{$style.class} buttons"><a class="{$style.identif}" href="{$style.link}" data-varid="{echo $product->firstVariant->getId()}" data-prodid="{echo $product->getId()}" >{$style.message}</a></div>
                                </div>
                            </div>
                            <div class="f_r t-a_r">
                                <span class="ajax_refer_marg">
                                    {if $forCompareProducts && in_array($product->getId(), $forCompareProducts)}
                                        <a href="{shop_url('compare')}" class="">Сравнить</a>
                                    {else:}
                                        <a href="{shop_url('compare/add/'. $product->getId())}" data-prodid="{echo $product->getId()}" class="js gray toCompare">Добавить к сравнению</a>
                                    {/if}
                                </span>
                                {if !is_in_wish($product->getId())}
                                    <a data-logged_in="{if ShopCore::$ci->dx_auth->is_logged_in()===true}true{/if}" data-varid="{echo $product->firstVariant->getId()}" data-prodid="{echo $product->getId()}" href="#" class="js gray addToWList">Сохранить в список желаний</a>
                                {else:}
                                    <a href="/shop/wish_list">Уже в списке желаний</a>
                                {/if}
                            </div>
                        </div>
                        {if $product->countProperties() > 0}
                        <p class="c_b">
                            {echo ShopCore::app()->SPropertiesRenderer->renderPropertiesInline($product)}
                            <a href="{shop_url('product/' . $product->getUrl())}" class="t-d_n"><span class="t-d_u">Подробнее</span> ></a>
                        </p>
                        {/if}
                    </li>
                    {/foreach}
                    <!--  Render produts list   -->
                </ul>

                <!--    Pagination    -->
                <div class="pagination"><div class="t-a_c">{$pagination}</div></div>
                <!--    Pagination    -->
            </div>

            <!--   Right sidebar     -->
            <div class="nowelty_auction">
                <!--   New products block     -->
                <div class="box_title">
                    <span>Новинки</span>
                </div>
                <ul>
                    {foreach getPromoBlock('hot', 3) as $hotProduct}
                    <li class="smallest_item">
                        <div class="photo_block">
                            <a href="{shop_url('product/' . $hotProduct->getUrl())}">
                                <img src="{productImageUrl($hotProduct->getSmallModimage())}" alt="{echo ShopCore::encode($hotProduct->getName())}" />
                            </a>
                        </div>
                        <div class="func_description">
                            <a href="{shop_url('product/' . $hotProduct->getUrl())}" class="title">{echo ShopCore::encode($hotProduct->getName())}</a>
                            <div class="buy">
                                <div class="price f-s_14">{echo $hotProduct->firstVariant->toCurrency()} 
                                    <sub>{$CS}</sub>
                                    {if $NextCS != $CS}
                                    <span class="d_b">{echo $hotProduct->firstVariant->toCurrency('Price', $NextCSId)} {$NextCS}</span>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </li>
                    {/foreach}
                </ul>
                <!--   New products block     -->

                <!--   Promo products block     -->
                <div class="box_title">
                    <span>Акции</span>
                </div>
                <ul>
                    {foreach getPromoBlock('action', 3) as $hotProduct}
                    <li class="smallest_item">
                        <div class="photo_block">
                            <a href="{shop_url('product/' . $hotProduct->getUrl())}">
                                <img src="{productImageUrl($hotProduct->getSmallModImage())}" alt="{echo ShopCore::encode($hotProduct->getName())}" />
                            </a>
                        </div>
                        <div class="func_description">
                            <a href="{shop_url('product/' . $hotProduct->getUrl())}" class="title">{echo ShopCore::encode($hotProduct->getName())}</a>
                            <div class="buy">
                                <div class="price f-s_14">{echo $hotProduct->firstVariant->toCurrency()} 
                                    <sub>{$CS}</sub>
                                    {if $NextCS != $CS}
                                    <span class="d_b">{echo $hotProduct->firstVariant->toCurrency('Price', $NextCSId)} {$NextCS}</span>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </li>
                    {/foreach}
                </ul>
                <!--   Promo products block     -->
            </div>
            <!--   Right sidebar     -->

        </div>
    </div>
</div>