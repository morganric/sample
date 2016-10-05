module ApplicationHelper


def deparametrize(str)
  str.split("-").join(" ").humanize
end

end
