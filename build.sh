# Builds my elm project and outputs the contents to `build/index.html` and `build/elm.js`


mkdir build

elm make src/Main.elm --output --optimize elm.js
uglifyjs elm.js --compress 'pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output build/elm.js

cp index.html build/index.html
