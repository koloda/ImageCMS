<!-- Top search panel -->
<div class="top-navigation">
    <div style="float:left;">
        <div style="padding-left:10px;">
            <form style="width:100%;" onsubmit="return false;" method="post" action="{$BASE_URL}admin/admin_search" id="g_search_form">
                <input type="text" value="{lang('a_search_pages')}..." name="search_text" class="textbox_long" onclick="if (this.value=='{lang('a_search_pages')}...') this.value='';" onblur="if (this.value=='') this.value='{lang('a_search_pages')}...';" />
                <input type="submit" value="Search" class="search_submit" onclick="ajax_form('g_search_form', 'page');"/>

                <a href="javascript:ajax_div('page', base_url + 'admin/admin_search/advanced_search')">{lang('a_advanced_search')}</a>
            </form>
        </div>
    </div>

    <div align="right" style="padding:7px 13px;">

        <input type="button" class="button_silver_130" value="{lang('a_create_page')}" onclick="ajax_div('page', base_url + 'admin/pages/index'); return false;" />
        <span style="padding:5px;"></span>
        <input type="button" class="button_silver_130" value="{lang('a_create_cat')}" onclick="ajax_div('page', base_url + 'admin/categories/create_form'); return false;" />

    </div>
</div>

{literal}
    <script>
        function edit_comment(id)
        { 
            new MochaUI.Window({
                id: 'edit_comment_window',
                title: 'Редактирование комментария',
                loadMethod: 'xhr',
                contentURL: base_url + 'admin/components/cp/comments/edit/' + id + '/dashboard',
                width: 500,
                height: 280
            });
        }
    </script>
{/literal}

<div id="board_content">

    <div style="width:70%;float:left;margin-right:20px;margin-left:5px; ">
        <div style="background-color: #BBD45F; padding:10px; font-weight:bold;">
            <img src="{$THEME}/images/documents-text.png" width="16" height="16" align="top" style="padding-right:15px;" />
            {lang('a_pages')}
        </div>
        <div>

            <h3 style="padding:3px;margin-top:5px;">{lang('a_new_pages')}</h3>         
            <table class="s_table" width="100%" cellpadding="3">
                <tbody>
                    {foreach $latest as $l}
                        <tr>
                            <td><a href="#" onclick="ajax_div('page','{$BASE_URL}admin/pages/edit/{$l.id}'); return false;" >{truncate($l.title, 40, '...')}</a></td>
                            <td><a href="#" onclick="cats_options({$l.category}); return false;" >{truncate(get_category_name($l.category), 20, '...')}</a></td>
                            <td>
                                <a href="{$BASE_URL}{$l.cat_url}{$l.url}" target="_blank">{truncate($l.url, 20, '...')}</a> 
                            </td>
                            <td>{date('Y-m-d H:i:s', $l['created'])}</td>
                            <td align="right">
                                <img onclick="ajax_div('page','{$BASE_URL}admin/pages/edit/{$l.id}/{$l.lang}');" style="cursor:pointer" src="{$THEME}/images/edit_page.png" width="16" height="16" title="{lang('a_edit')}" /> 
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>

            <h3 style="padding:3px;margin-top:5px;">{lang('a_updated_pages')}</h3>         
            <table class="s_table" width="100%" cellpadding="3">
                <tbody>
                    {foreach $updated as $l}
                        <tr>
                            <td><a href="#" onclick="ajax_div('page','{$BASE_URL}admin/pages/edit/{$l.id}'); return false;" >{truncate($l.title, 40, '...')}</a></td>
                            <td><a href="#" onclick="cats_options({$l.category}); return false;" >{truncate(get_category_name($l.category), 20, '...')}</a></td>
                            <td>
                                <a href="{$BASE_URL}{$l.cat_url}{$l.url}" target="_blank">{truncate($l.url, 20, '...')}</a> 
                            </td>
                            <td>{date('Y-m-d H:i:s', $l['updated'])}</td>
                            <td align="right">
                                <img onclick="ajax_div('page','{$BASE_URL}admin/pages/edit/{$l.id}/{$l.lang}');" style="cursor:pointer" src="{$THEME}/images/edit_page.png" width="16" height="16" title="{lang('a_edit')}" /> 
                            </td>
                        </tr>
                    {/foreach}                     
                </tbody>
            </table>
        </div>

    </div>

    <div style="float:left; width:25%; ">

        <div class="l_box" style="background-color: #ACBFC5; border-top:0px;">
            <img src="{$THEME}/images/application-browser.png" width="16" height="16" align="top" style="padding-right:15px;" />
            <b>{lang('a_system')}</b>
        </div>

        <div class="l_box">
            {lang('a_version')}: {$cms_number} <br />
            {if $sys_status.is_update == TRUE}
                <a href="#" onclick="ajax_div('page', base_url + 'admin/sys_upgrade');return false;">{lang('a_updates_to_version')} {$next_v}</a>
            {else:}
                {lang('a_no_updates')}.
            {/if}
            <br/>
            <a href="#" onclick="ajax_div('page', base_url + 'admin/sys_info');return false;">{lang('a_info')}</a> 
        </div>

        <div class="l_box" style="background-color: #ACBFC5; border-top:0px;">
            <img src="{$THEME}/images/application-list.png" width="16" height="16" align="top" style="padding-right:15px;" />
            <b>{lang('a_stat')}</b>
        </div>

        <div class="l_box">
            {lang('a_pages')}: {$total_pages} <br />
            {lang('a_cats')}: {$total_cats} <br />
            {lang('a_comments')}: {$total_comments} <br />
        </div>

        <div class="l_box" style="background-color: #ACBFC5;">
            <img src="{$THEME}/images/balloon.png" width="16" height="16" align="top" style="padding-right:15px;" />
            <b>{lang('a_last_comm')}</b>
        </div>

        <div class="l_box">
            {foreach $comments as $c}
                <div class="d_comment" onclick="edit_comment({$c.id});">
                    <span style="font-size:11px;">{date('d-m-Y H:i', $c.date)}</span>
                    <br/>
                    <i>{$c.user_name}:</i> {truncate($c.text, 50, '...')}
                    <hr style="border-top:1px solid #A5A5A5;" />
                </div>
            {/foreach}
        </div>
        
        {($hook = get_hook('admin_tpl_dashboard_sidebar')) ? eval($hook) : NULL;}
        
        
        
        <div class="l_box" style="background-color: #ACBFC5;">
            <img src="{$THEME}/images/balloon.png" width="16" height="16" align="top" style="padding-right:15px;" />
            <b>{lang('a_cms_news')}</b>
        </div>
                        {($hook = get_hook('admin_tpl_dashboard_center')) ? eval($hook) : NULL;}
             {if count($api_news) > 1}
        <div class="l_box">            
               {foreach $api_news as $a}
                    <span style="font-size:11px;">{date('d-m-Y H:i', $a.publish_date)}
                    <a style="padding-left:10px;" target="_blank" href="http://www.imagecms.net/blog/news/{$a.url}">>>></a>
                    </span>
                    <br/> {truncate(strip_tags($a.prev_text), 100)}
                    <hr style="border-top:1px solid #A5A5A5;" />
                
            {/foreach}
        </div>
 {/if}
        

    </div>

</div>
