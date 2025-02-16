#import "style.typ": gost-style
#import "component/title.typ": title
#import "title-templates/lib.typ": templates
#import "component/performers.typ": performers-page, fetch-performers

#let gost-common(..arguments, title-template: templates.default) = {
  arguments = arguments.named()
  let hide-title = arguments.remove("hide-title")

  arguments.performers = fetch-performers(arguments.performers)

  if not hide-title {
    title(title-template, ..arguments)
  }

  if arguments.performers != none and arguments.performers.len() > 1 {
    performers-page(arguments.performers)
  }

  context if (counter(page).final().first() >= 10 or arguments.force-outline) and query(selector(heading)).len() > 0 and query(<abstract>).len() == 0 {
    outline()
  }
}

#let gost(
  ministry: none,
  organization: (full: none, short: none),
  udk: none,
  gos-no: none,
  inventory-no: none,
  performers: none,
  approved-by: (name: none, position: none, year: auto),
  agreed-by: (name: none, position: none, year: auto),
  report-type: "Отчёт",
  about: none, 
  part: none,
  bare-subject: false,
  research: none,
  subject: none,
  stage: none,
  manager: (position: none, name: none),
  city: none,
  year: auto,
  force-outline: false,
  hide-title: false,
  body
) = {
  if year == auto {
    year = int(datetime.today().display("[year]"))
  }

  [#metadata(force-outline) <force-outline>]

  show: gost-style.with(year: year, city: city)

  gost-common(ministry: ministry, organization: organization, udk: udk, gos-no: gos-no, inventory-no: inventory-no, performers: performers, approved-by: approved-by, agreed-by: agreed-by, report-type: report-type, about: about, part: part, bare-subject: bare-subject, research: research, subject: subject, stage: stage, manager: manager, city: city, year: year, force-outline: force-outline, hide-title: hide-title)

  body
}