# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

masla1 = Masla.create(uid: "1", typeOfInput: "text", typeOfMasla: "masla", entries: ["masla1", "masla2", "masla3"], answerUrdu: "answerUrdu1", answerEnglish: "answerEnglish1")
masla2 = Masla.create(uid: "2", typeOfInput: "text", typeOfMasla: "masla", entries: ["masla1", "masla2", "masla3"], answerUrdu: "answerUrdu2", answerEnglish: "answerEnglish2")
masla3 = Masla.create(uid: "3", typeOfInput: "text", typeOfMasla: "masla", entries: ["masla1", "masla2", "masla3"], answerUrdu: "answerUrdu3", answerEnglish: "answerEnglish3")

premasla1 = PreMasla.create(masla: masla1, premasla: "type1", value: "value1")
premasla2 = PreMasla.create(masla: masla1, premasla: "type2", value: "value2")
premasla3 = PreMasla.create(masla: masla1, premasla: "type3", value: "value3")

premasla4 = PreMasla.create(masla: masla2, premasla: "type1", value: "value1")
premasla5 = PreMasla.create(masla: masla2, premasla: "type2", value: "value2")

premasla6 = PreMasla.create(masla: masla3, premasla: "type1", value: "value1")