<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Cms_hooks {

    public function __construct()
    {
        $ci =& get_instance();

        $hooks_file = './system/cache/hooks'.EXT;

        if (!file_exists($hooks_file) OR $ci->config->item('rebuild_hooks_tree') === TRUE)
        {
            $this->build_hooks();
        }
        
        include($hooks_file);
    }

    public function build_hooks()
    {
        $ci =& get_instance();

        $ci->load->library('lib_xml');

        $xml = '<?xml version="1.0" encoding="UTF-8"?><hooks>';

        // Get all installed modules
        $ci->db->select('name');
        $modules = $ci->db->get('components')->result_array();

        $modules[]['name'] = 'core';

        // Search for hooks.xml in all installed modules
        foreach($modules as $m)
        {
            $xml_file = APPPATH.'modules/'.$m['name'].'/hooks.xml';
            
            if (file_exists($xml_file))
            {
                $xml .= file_get_contents($xml_file);
            }
        }

        $xml .= "\n</hooks>";

        $parser = xml_parser_create();
    	xml_parser_set_option($parser, XML_OPTION_CASE_FOLDING, 0);
	    xml_parser_set_option($parser, XML_OPTION_SKIP_WHITE, 1);
    	xml_parse_into_struct($parser, $xml, $vals);
	    xml_parser_free($parser);

        $tmp = array();

        foreach($vals as $k => $v)
        {
            if ($v['type'] == 'complete' AND trim($v['value']) != '' AND trim($v['attributes']['id'] != ''))
            {
                $hook_id = $v['attributes']['id']; 

                $tmp[$hook_id] .= $v['value'];
            }
        }


        $this->create_hooks_file($tmp);

    }

    private function create_hooks_file($hooks_arr = array())
    {
        $ci =& get_instance();
        $ci->load->helper('file');

        $tmp = '';

        if (count($hooks_arr) > 0)
        {
            foreach($hooks_arr as $k => $v)
            {
                $tmp .= '\''.$k.'\''.' => \''.str_replace("'", "\'",$v).'\','."\n";
            }
        }
        
        $tmp = str_replace("\\\'", "\'", $tmp); 

        $template = "<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

function get_hook(\$hook_id)
{
\$cms_hooks = array (
    ".$tmp."
);

    if (isset(\$cms_hooks[\$hook_id]))
    {
        return \$cms_hooks[\$hook_id];
    }
    else
    {
       return FALSE;
    }
}

";
        write_file('./system/cache/hooks'.EXT, $template);
    }
}