# Word Classifier

Download Dictionary

    https://github.com/hola/challenge_word_classifier/blob/master/words.txt

Build a set of positive and negative word matches

    for i in {1..10000}; do curl -L https://hola.org/challenges/word_classifier/testcase >> test_cases.txt; done
    ruby extract_negative_test_cases.rb

Make sure there are the same number of positive and negative test cases

    head -n 550000 negative_test_cases.txt > tmp_file && mv tmp_file negative_test_cases.txt
    head -n 550000 positive_test_cases.txt > tmp_file && mv tmp_file positive_test_cases.txt

Build matchers

    ruby build_matchers.rb 
