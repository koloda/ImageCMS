<div class="top-navigation">
    <div style="float:left;">
        <ul>
        <li>
            <p><input type="button" class="button_silver_130" value="{lang('amt_all_tickets')}" onclick="ajax_div('page', base_url + 'admin/components/cp/user_support'); return false;" /></p>
        </li>
    
        <li>
            <input type="button" class="button_silver_130" value="{lang('amt_departments')}" onclick="ajax_div('page', base_url + 'admin/components/cp/user_support/departments'); return false;" />
        </li>

        </ul>
    </div>

</div>
<div style="clear:both"></div>

<form action="{$BASE_URL}admin/components/cp/user_support/create_department" method="post" id="save_form" style="width:100%;">
{form_csrf()}
	<div class="form_text">{lang('amt_tname')}:</div>
	<div class="form_input"><input type="text" name="name" value="" class="textbox_long" /></div>
	<div class="form_overflow"></div>

	<div class="form_text"></div>
	<div class="form_input">
	<input type="submit" name="button" class="button" value="{lang('amt_save')}" onclick="ajax_me('save_form');" />
	</div>
</form>
