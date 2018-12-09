##### functions ###

vars_init() {

	set -o nounset

	readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
	readonly __file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
	readonly __base="$(basename ${__file})"
	readonly __root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app

	set +o nounset
}
