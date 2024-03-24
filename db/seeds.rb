
admin = UserRole.create(name: :admin, label: 'Admin', can_delete: true, can_update: true)
hazapper = UserRole.create(name: :hazapper, label: 'HazApper', can_update: true)
personalapper = UserRole.create(name: :personal_apper, label: 'PersonalApper', has_masla: true)

adminUser = User.create(username: :admin, password: '123456', user_role: admin)
hazapperUser = User.create(username: :hazapper, password: '123456', user_role: hazapper)
personalapperUser = User.create(username: :personalapper, password: '123456', user_role: personalapper)

masla1 = Masla.create(uid: '1', typeOfInput: 'text1', typeOfMasla: 'masla', entries: %w[masla1 masla2 masla3],
                      answerUrdu: 'answerUrdu1', answerEnglish: 'answerEnglish1', user: user1)
masla2 = Masla.create(uid: '2', typeOfInput: 'text2', typeOfMasla: 'masla', entries: %w[masla1 masla2 masla3],
                      answerUrdu: 'answerUrdu2', answerEnglish: 'answerEnglish2', user: user1)
masla3 = Masla.create(uid: '3', typeOfInput: 'text3', typeOfMasla: 'masla', entries: %w[masla1 masla2 masla3],
                      answerUrdu: 'answerUrdu3', answerEnglish: 'answerEnglish3')
masla4 = Masla.create(uid: '4', typeOfInput: 'text3', typeOfMasla: 'masla', entries: %w[masla1 masla2 masla3],
                      answerUrdu: 'answerUrdu3', answerEnglish: 'answerEnglish3', user: user2)

MoreInfo.create(masla: masla1, info: 'type1', value: 'value1')
MoreInfo.create(masla: masla1, info: 'type2', value: 'value2')
MoreInfo.create(masla: masla1, info: 'type3', value: 'value3')
MoreInfo.create(masla: masla2, info: 'type1', value: 'value1')
MoreInfo.create(masla: masla2, info: 'type2', value: 'value2')
MoreInfo.create(masla: masla3, info: 'type1', value: 'value1')
