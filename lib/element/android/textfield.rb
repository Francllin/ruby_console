# encoding: utf-8
# UIATextField methods

# Get an array of textfield texts.
# @return [Array<String>]
def textfields
  find_eles_attr :textfield, :text
end

# Get an array of textfield elements.
# @return [Array<Textfield>]
def e_textfields
  find_eles :textfield
end

# Get the first textfield element.
# @return [Textfield]
def first_textfield
  first_ele :textfield
end

# Get the last textfield element.
# @return [Textfield]
def last_textfield
  last_ele :textfield
end

# Get the first textfield that matches text.
# @param text [String] the text to match exactly
# @return [Textfield]
def textfield text
  find_ele_by_text :textfield, text
end

# Get the first textfield that includes text.
# @param text [String] the text the textfield must include
# @return [Textfield]
def textfield_include text
  find_ele_by_text_include :textfield, text
end