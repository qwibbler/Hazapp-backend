masla1 = Masla.create(uid: '1', typeOfInput: 'text', typeOfMasla: 'masla', entries: %w[masla1 masla2 masla3],
                      answerUrdu: 'answerUrdu1', answerEnglish: 'answerEnglish1')
masla2 = Masla.create(uid: '2', typeOfInput: 'text', typeOfMasla: 'masla', entries: %w[masla1 masla2 masla3],
                      answerUrdu: 'answerUrdu2', answerEnglish: 'answerEnglish2')
masla3 = Masla.create(uid: '3', typeOfInput: 'text', typeOfMasla: 'masla', entries: %w[masla1 masla2 masla3],
                      answerUrdu: 'answerUrdu3', answerEnglish: 'answerEnglish3')

MoreInfo.create(masla: masla1, info: 'type1', value: 'value1')
MoreInfo.create(masla: masla1, info: 'type2', value: 'value2')
MoreInfo.create(masla: masla1, info: 'type3', value: 'value3')
MoreInfo.create(masla: masla2, info: 'type1', value: 'value1')
MoreInfo.create(masla: masla2, info: 'type2', value: 'value2')
MoreInfo.create(masla: masla3, info: 'type1', value: 'value1')
