class RedCloth::TextileDoc
  def refs_smiley(text)
    text.gsub!(/\[em:(sorry|happy|despise|rage|laugh|happy|shy|asleep|grin|scared|pleasantsuprise|cry|puzzled|bother|strive|amative|angry|painful|sad|impatient|faint)\]/) do |m|
      "<img src=\"/images/mantou/#{m[4..-2]}.png\" alt=\"#{m[4..-2]}\" />"
    end
  end
end