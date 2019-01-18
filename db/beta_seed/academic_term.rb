# frozen_string_literal: true

academic_terms = [
  {
    year: '2018 - 2019',
    term: 'fall',
    start_of_term: '2018-09-01 00:00:00',
    end_of_term: '2019-01-30 00:00:00',
    active: true
  },
  {
    year: '2018 - 2019',
    term: 'spring',
    start_of_term: '2019-02-02 00:00:00',
    end_of_term: '2019-06-21 00:00:00',
    active: false
  },
  {
    year: '2017 - 2018',
    term: 'fall',
    start_of_term: '2017-09-17 00:00:00',
    end_of_term: '2018-01-31 00:00:00',
    active: false
  },
  {
    year: '2017 - 2018',
    term: 'spring',
    start_of_term: '2018-01-27 00:00:00',
    end_of_term: '2018-06-28 00:00:00',
    active: false
  },
  {
    year: '2017 - 2018',
    term: 'summer',
    start_of_term: '2018-06-11 00:00:00',
    end_of_term: '2018-07-27 00:00:00',
    active: false
  }
]

AcademicTerm.create(academic_terms)
