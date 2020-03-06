if (typeof(CKEDITOR) != 'undefined') {
    CKEDITOR.editorConfig = function (config) {
        config.toolbarGroups = [
            {name: 'document', groups: ['mode', 'document', 'doctools']},
            {name: 'clipboard', groups: ['clipboard', 'undo']},
            {name: 'editing', groups: ['find', 'selection', 'spellchecker', 'editing']},
            {name: 'forms', groups: ['forms']},
            {name: 'basicstyles', groups: ['basicstyles', 'cleanup']},
            {name: 'paragraph', groups: ['list', 'indent', 'blocks', 'align', 'bidi', 'paragraph']},
            {name: 'links', groups: ['links']},
            {name: 'insert', groups: ['insert']},
            {name: 'styles', groups: ['styles']},
            {name: 'colors', groups: ['colors']},
            {name: 'tools', groups: ['tools']},
            {name: 'others', groups: ['others']},
            {name: 'about', groups: ['about']}
        ];

        config.removeButtons = 'Source,Save,Templates,NewPage,Preview,Print,Replace,Find,SelectAll,Scayt,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,Superscript,Subscript,CreateDiv,BidiLtr,BidiRtl,Language,Flash,Smiley,Iframe,Anchor,Styles,Font,FontSize,ShowBlocks,About,Outdent,Indent,Blockquote';
        config.extraPlugins = 'embed,autoembed';
    };
}